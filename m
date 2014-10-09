From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Reset DMA before enabling IDMAC
Date: Fri, 10 Oct 2014 03:49:28 +0530
Message-ID: <CAGOxZ520EXdS9FoCVW7GPvheNSZu=xqc2makJY5D0c3zjVBkDw@mail.gmail.com>
References: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
 <CAGOxZ53bviLbuA27=1QjNUgxA_WMMP-6siV=DajuN8iSqsasMg@mail.gmail.com> <CAO3aYcqi0g=eJta33s5oM-tAAmAhe86VvHd43p5RJ7qMPZzfrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO3aYcqi0g=eJta33s5oM-tAAmAhe86VvHd43p5RJ7qMPZzfrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?RWRkaWUgQ2FpKOiUoeaeqyk=?= <eddie.cai@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, addy.ke@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Hi Eddie,

On Thu, Oct 9, 2014 at 7:43 PM, Eddie Cai(=E8=94=A1=E6=9E=AB) <eddie.ca=
i@rock-chips.com> wrote:
> Hi Alim
>
> 2014=E5=B9=B410=E6=9C=888=E6=97=A5 =E4=B8=8A=E5=8D=884:28=E4=BA=8E "A=
lim Akhtar" <alim.akhtar@gmail.com>=E5=86=99=E9=81=93=EF=BC=9A
>
>
>>
>> Hi Sonny/Doug,
>>
>> On Mon, Oct 6, 2014 at 11:23 PM, Sonny Rao <sonnyrao@chromium.org> w=
rote:
>> > We've already got a reset of DMA after it's done.  Add one before =
we
>> > start DMA too.  This fixes a data corruption on Rockchip SoCs whic=
h
>> > will get bad data when doing a DMA transfer after doing a PIO tran=
sfer.
>> >
>> > We tested this on an Exynos 5800 with HS200 and didn't notice any
>> > difference in sequential read throughput.
>> >
>> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> > Signed-off-by: Doug Anderson <dianders@chromium.org>
>> > ---
>> >  drivers/mmc/host/dw_mmc.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> > index 69f0cc6..2b5401e 100644
>> > --- a/drivers/mmc/host/dw_mmc.c
>> > +++ b/drivers/mmc/host/dw_mmc.c
>> > @@ -83,6 +83,7 @@ struct idmac_desc {
>> >  #endif /* CONFIG_MMC_DW_IDMAC */
>> >
>> >  static bool dw_mci_reset(struct dw_mci *host);
>> > +static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>> >
>> >  #if defined(CONFIG_DEBUG_FS)
>> >  static int dw_mci_req_show(struct seq_file *s, void *v)
>> > @@ -448,6 +449,9 @@ static void dw_mci_idmac_start_dma(struct dw_m=
ci
>> > *host, unsigned int sg_len)
>> >
>> >         dw_mci_translate_sglist(host, host->data, sg_len);
>> >
>> > +       /* Make sure to reset DMA in case we did PIO before this *=
/
>> > +       dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET);
>> > +
>> Though this is good to do, but this does not look complete to me.
>> dw_mmc data book does mention that " It is recommended that the host
>> issue reset to DMA interface by setting DMA_RESET bit of the CTRL
>> register and then issue a IDMAC software reset."
>> The above lines are from 'Transmission and reception with internal
>> DMA' section of the data book.
>> My suggestion here to add dw_mci_idmac_reset() call after this above
>> change.
>>
>> What is the controller version used in your case?
>
> it just compatible with dw mmc controler but not the same one. it is
> designed by rockchip.
>
Thats fine, I think every vendor (most of them) has a custom
implementation of dw_mmc, but they do have VERID register to check the
dw_mmc version.
The reason why I asked is, I have seen inconsistency in card
enumeration on few controller version, and this patch alone does not
help, and adding a call to dw_mci_idmac_reset() after DMA reset is
needed. And this is what is recommended in the synopsys's data book
also.
Do you see any issue/side effect after adding dw_mci_idmac_reset()?

>> >         /* Select IDMAC interface */
>> >         temp =3D mci_readl(host, CTRL);
>> >         temp |=3D SDMMC_CTRL_USE_IDMAC;
>> > --
>> > 1.8.3.2
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Regards,
>> Alim
>>
>>



--=20
Regards,
Alim
