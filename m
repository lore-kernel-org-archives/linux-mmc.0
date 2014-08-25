From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/10 v2 resend] mmc: block: add block number limitation
 flag for multiple block read
Date: Mon, 25 Aug 2014 10:50:57 +0200
Message-ID: <CAPDyKFqkstphRrj_0EFx52Snboaz8NryxXkFgY8Zb-CLeGhMZw@mail.gmail.com>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<8761hk7wgy.wl%kuninori.morimoto.gx@gmail.com>
	<874mx47wf9.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFqwDTBu53t6iiiA6REe3feBFWWmgd-V93RsOh5XFPpc4w@mail.gmail.com>
	<87fvgltmnn.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87fvgltmnn.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 25 August 2014 02:53, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulf
>
> Thank you for your feedback
>
>> > MMC_CAP2_NO_MULTI_READ flags disable all multiple block read,
>> > but, it is over-kill for this issue.
>> > This patch adds new MMC_CAP2_2BLKS_LIMIT to use single block read
>> > when it was two blocks.
>> > This is additional option of MMC_CAP2_NO_MULTI_READ
>> >
>> > [Kuninori Morimoto: tidyup for upstreaming, and cared mach-shmobile]
>> >
>> > Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
>> > Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>> > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > ---
>> >  arch/arm/mach-shmobile/board-koelsch.c |    6 +++---
>> >  arch/arm/mach-shmobile/board-lager.c   |    4 ++--
>>
>> I prefer to split up patches into ARM patches and MMC patches if it's possible.
>> That makes it easier to review and collect acks from SoC maintainers.
>
> I see. will do
>
>> > @@ -331,7 +331,7 @@ SDHI_REGULATOR(2, RCAR_GP_PIN(7, 19), RCAR_GP_PIN(2, 26));
>> >  static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
>> >         .tmio_caps      = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>> >                           MMC_CAP_POWER_OFF_CARD,
>> > -       .tmio_caps2     = MMC_CAP2_NO_MULTI_READ,
>> > +       .tmio_caps2     = MMC_CAP2_NO_2BLKS_READ,
>>
>> Why are MMC_CAP2_NO_MULTI_READ /MMC_CAP2_NO_2BLKS_READ configured from
>> platform data. If this is HW bug, aren't that related to the actual
>> mmc controller and version of it - not the board/platform?
>
> In historical reason, your idea can be implemented on DT case.
> But above style is very normal for non-DT case in this driver...
>
>> This applies to more caps and boards further down below in this patch as well.
>>
>> To me, it seems like these belongs into the host driver instead!?
>
> This issue is similar to MMC_CAP2_NO_MULTI_READ,
> and it is located in block.c.
> So, we added it there too.
>
> If you can't accept it, we will consider it again.
> But is it possilbe to keep consistency if host side exchange block size
> without using framework ??

Nope, we need adaptations to the framework and I have no objections to that.

>
>> > @@ -1400,8 +1400,23 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>> >
>> >                 /* Some controllers can't do multiblock reads due to hw bugs */
>> >                 if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
>> > -                   rq_data_dir(req) == READ)
>> > -                       brq->data.blocks = 1;
>> > +                   rq_data_dir(req) == READ) {
>> > +
>> > +                       if (card->host->caps2 & MMC_CAP2_2BLKS_LIMIT) {
>>
>> This conforms to what the commit message states, that
>> MMC_CAP2_2BLKS_LIMIT needs to be used together with
>> MMC_CAP2_NO_MULTI_READ to take effect. I think I would prefer to have
>> them separate.
>>
>> Anyway, according to your cap configuration changes, you are replacing
>> MMC_CAP2_NO_MULTI_READ with MMC_CAP2_2BLKS_LIMIT, instead of adding
>> it...
>
> Because this method will check caps2 flag twice for
> MMC_CAP2_2BLKS_LIMIT and MMC_CAP2_NO_MULTI_READ in such case.
> But, these are similar flag, and is no effect for almost all drivers.
> We avoided such checks.

I see, but I don't think such "optimization" is worth much. To me it
just adds a bit of confusion. I would prefer to have them separate.

Kind regards
Uffe
