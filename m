From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_test: mention that '0' runs all tests
Date: Fri, 29 Jan 2016 12:41:09 +0100
Message-ID: <CAPDyKFrMH5W0fNmo1Y5P_azT0Pn=Gx25J5itjo8AEpuv9o4-PQ@mail.gmail.com>
References: <1453749604-2236-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1453749604-2236-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 25 January 2016 at 20:20, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I had to use the source to determine what I need to write to 'test' so
> that all tests are run. Let's mention this explicitly in 'testlist'.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/card/mmc_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 7fc9174d46191a..c032eef45762c1 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -2829,6 +2829,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
>
>         mutex_lock(&mmc_test_lock);
>
> +       seq_printf(sf, "0:\tRun all tests\n");
>         for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++)
>                 seq_printf(sf, "%d:\t%s\n", i+1, mmc_test_cases[i].name);
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
