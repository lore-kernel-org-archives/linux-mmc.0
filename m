From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: change controller error info to
 debug level
Date: Fri, 24 Mar 2017 15:52:08 +0800
Message-ID: <1662971490341928@web27j.yandex.ru>
References: <20170316132903.61246-1-icenowy@aosc.xyz> <CAPDyKFppqPjjXtAAcSynxMw-1Oc7W6ZMf=oJLzWwsnLUWCq5Rw@mail.gmail.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBKNA2PDAKGQEYGFXICQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAPDyKFppqPjjXtAAcSynxMw-1Oc7W6ZMf=oJLzWwsnLUWCq5Rw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



24.03.2017, 15:46, "Ulf Hansson" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> On 16 March 2017 at 14:29, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
>> =C2=A0The controller's errors are usually normal (for example, for MMC o=
r SDIO
>> =C2=A0cards, some errors are expected to happen; and for boards without =
a
>> =C2=A0dedicated card detect pin the error info will even flood console a=
nd
>> =C2=A0hide other normal messages) and hard to understand.
>>
>> =C2=A0Change their print level to debug, thus it won't be shown to gener=
ic
>> =C2=A0users.
>>
>> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>
> For some reason this change didn't enter the mmc patchtracker. However
> I have picked it up for next anyway.

Thanks!

Maybe it's because of the e-mail provider chosen by AOSC (Yandex.Mail).

Sorry. I will try to ask for a migration to other e-mail provider.

>
> Thanks!
>
> Kind regards
> Uffe
>
>> =C2=A0---
>> =C2=A0=C2=A0drivers/mmc/host/sunxi-mmc.c | 2 +-
>> =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> =C2=A0diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi=
-mmc.c
>> =C2=A0index 6ffcd2838272..0391c62cc99f 100644
>> =C2=A0--- a/drivers/mmc/host/sunxi-mmc.c
>> =C2=A0+++ b/drivers/mmc/host/sunxi-mmc.c
>> =C2=A0@@ -489,7 +489,7 @@ static void sunxi_mmc_dump_errinfo(struct sunx=
i_mmc_host *host)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0cmd->opcode =3D=3D SD_IO_RW_DIRECT))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>>
>> =C2=A0- dev_err(mmc_dev(host->mmc),
>> =C2=A0+ dev_dbg(mmc_dev(host->mmc),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n=
",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host->mmc->index, cmd->opcode,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data ? (data->flags & MMC_DATA_WRITE ? " WR" =
: " RD") : "",
>> =C2=A0--
>> =C2=A02.12.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
