class TransactionsController < ApplicationController
  include CurrentUser # Ensure user is authenticated

  def create
    transaction = Transaction.new(transaction_params)

    if transaction.save
      render json: transaction.slice(:id, :amount, :transaction_type, :source_wallet_id, :target_wallet_id), status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :source_wallet_id, :target_wallet_id)
  end
end
