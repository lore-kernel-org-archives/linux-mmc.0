From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci_qcom_dml: fix is never less than zero warning.
Date: Tue, 9 Sep 2014 13:53:13 +0200
Message-ID: <CAPDyKFr=rLk2paKktTd_fkX7TcS+YW=A0RS-e5rYXGST3KAy7A@mail.gmail.com>
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1410251689-12740-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410251689-12740-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 September 2014 10:34, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch fixes a typo which resulted in 'is never less
> than zero warning' reported by static checker.
>
>         drivers/mmc/host/mmci_qcom_dml.c:131 dml_hw_init()
>         warn: unsigned 'producer_id' is never less than zero.
>
> drivers/mmc/host/mmci_qcom_dml.c
>    121  /* Initialize the dml hardware connected to SD Card controller */
>    122  int dml_hw_init(struct mmci_host *host, struct device_node *np)
>    123  {
>    124          u32 config;
>    125          void __iomem *base;
>    126          u32 consumer_id, producer_id;
>    127
>    128          consumer_id = of_get_dml_pipe_index(np, "tx");
>    129          producer_id = of_get_dml_pipe_index(np, "rx");
>    130
>    131          if (producer_id < 0 || consumer_id < 0)
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    132
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Hi Ulf,
>
> This patch is on top of https://git.linaro.org/people/ulf.hansson/mmc.git next branch
> to fix up a warning reported by static checker tool.
>
> Are you ok to take this patch as it is or do you think I should resend the
> original DML patch with this fix?
>

I am fine with this, I will fold it into the original patch. Applied for next.

Kind regards
Uffe

> thanks,
> srini
>
>  drivers/mmc/host/mmci_qcom_dml.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 300ef50..2b7fc37 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -123,7 +123,7 @@ int dml_hw_init(struct mmci_host *host, struct device_node *np)
>  {
>         u32 config;
>         void __iomem *base;
> -       u32 consumer_id, producer_id;
> +       int consumer_id, producer_id;
>
>         consumer_id = of_get_dml_pipe_index(np, "tx");
>         producer_id = of_get_dml_pipe_index(np, "rx");
> --
> 1.9.1
>
