From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
Date: Tue, 20 Nov 2018 10:42:07 +0100
Message-ID: <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com> <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> Refer to "4.15 set block count command" of sd specification:
> Host needs to issue CMD12 if any error is detected in
> the CMD18 and CMD25 operations.
>
> In sbc case, the data->stop is fill by framework.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 82bab35..13fa640 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                         /* The error clause is handled above, success! */
>                         data->bytes_xfered = data->blksz * data->blocks;
>
> -               if (!data->stop || host->mrq->sbc) {
> +               if (!data->stop || (host->mrq->sbc && !data->error))
>                         mmci_request_end(host, data->mrq);
> -               } else {
> +               else
>                         mmci_start_command(host, data->stop, 0);

This looks correct to me!

Although, just wanted to double check that you tested this for a case
where we have host->mrq->sbc set and got an error in data->error? I
guess it can be tricky, so I was thinking of manually trying to
instruct the code, to set an error in data->error, at some point to
trigger this code. That would at least give us some confidence that it
works as expected.

Thoughts?

> -               }
>         }
>  }
>
> --
> 2.7.4
>

Kind regards
Uffe
