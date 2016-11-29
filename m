From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 8/8] mmc: mmc_test: remove BUG_ONs and deploy error handling
Date: Tue, 29 Nov 2016 13:41:39 +0100
Message-ID: <CAPDyKFqtaCH_KghhHPSYmHQHi39=SRbw7eCOWJC2O9p-zMZDrg@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com> <1478071617-12984-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35446 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2Mll (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:41:41 -0500
Received: by mail-wm0-f53.google.com with SMTP id a197so235923981wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:41:41 -0800 (PST)
In-Reply-To: <1478071617-12984-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:26, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> It is unnecessary to panic the kernel when testing mmc. Instead,
> cast a warning for folkz to debug and return the error code to
> the caller to indicate the failure of this test should be enough.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
>  drivers/mmc/card/mmc_test.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 5a8dc5a..db1a7ac 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -214,7 +214,8 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
>         struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
>         unsigned dev_addr, unsigned blocks, unsigned blksz, int write)
>  {
> -       BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
> +       if (WARN_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop))
> +               return;
>
>         if (blocks > 1) {
>                 mrq->cmd->opcode = write ?
> @@ -694,7 +695,8 @@ static int mmc_test_cleanup(struct mmc_test_card *test)
>  static void mmc_test_prepare_broken_mrq(struct mmc_test_card *test,
>         struct mmc_request *mrq, int write)
>  {
> -       BUG_ON(!mrq || !mrq->cmd || !mrq->data);
> +       if (WARN_ON(!mrq || !mrq->cmd || !mrq->data))
> +               return;
>
>         if (mrq->data->blocks > 1) {
>                 mrq->cmd->opcode = write ?
> @@ -714,7 +716,8 @@ static int mmc_test_check_result(struct mmc_test_card *test,
>  {
>         int ret;
>
> -       BUG_ON(!mrq || !mrq->cmd || !mrq->data);
> +       if (WARN_ON(!mrq || !mrq->cmd || !mrq->data))
> +               return -EINVAL;
>
>         ret = 0;
>
> @@ -755,7 +758,8 @@ static int mmc_test_check_broken_result(struct mmc_test_card *test,
>  {
>         int ret;
>
> -       BUG_ON(!mrq || !mrq->cmd || !mrq->data);
> +       if (WARN_ON(!mrq || !mrq->cmd || !mrq->data))
> +               return -EINVAL;
>
>         ret = 0;
>
> --
> 2.3.7
>
>
