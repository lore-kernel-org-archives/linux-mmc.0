From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
Subject: Re: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Thu, 9 Jul 2015 19:02:20 +0200
Message-ID: <559EA91C.6010408@melag.de>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com> <20150709075032.GD23464@tiger> <20150709092949.GB3917@shlinux1.ap.freescale.net> <20150709132736.GG23464@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:33871 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbbGIRDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2015 13:03:06 -0400
In-Reply-To: <20150709132736.GG23464@tiger>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <b29396@freescale.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, ulf.hansson@linaro.org, chris@printf.net, smoch@web.de, s.trumtrar@pengutronix.de, LW@KARO-electronics.de, marex@denx.de, rabeeh@solid-run.com, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, hs@denx.de, s.hauer@pengutronix.de, tharvey@gateworks.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, robertcnelson@gmail.com, linux-arm-kernel@lists.infradead.org, ipaton0@gmail.com, fabio.estevam@freescale.com, linux-mmc@vger.kernel.org, p.zabel@pengutronix.de, shawn.guo@linaro.org

Am 09.07.2015 um 15:27 schrieb Shawn Guo:

 > Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
> know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
> the best option.  I suggest you rebase the dts series on top of
> v4.2-rc1, and send it via mmc tree.

Yeah, I already stumbled across that. Fortunately, I dont need it at
all, so I just removed it from dts:


diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi
b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 2dea6dc..3c545e3 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -41,7 +41,6 @@
         pinctrl-0 =3D <&pinctrl_esdhc2>,
                     <&pinctrl_esdhc2_cdwp>;
         vmmc-supply =3D <&reg_3p3v>;
-       wp-gpios =3D <&gpio1 2 0>;
         cd-gpios =3D <&gpio1 4 0>;
         status =3D "disabled";
  };


--mtx

https://www.facebook.com/MELAG.Medizintechnik

[http://www.melag.de/fbbanner.png]<https://www.facebook.com/MELAG.Mediz=
intechnik>

MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg =
HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f=FCr ein=
en begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist =
ausschlie=DFlich f=FCr denjenigen bestimmt, an den sie gerichtet worden=
 ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d=FCrfen Sie dies=
e nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweis=
e in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt=FCmlich er=
halten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf =
diese Nachricht antworten. Bitte l=F6schen Sie in diesem Fall diese Nac=
hricht und alle Anh=E4nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged i=
nformation. It is intended only for the person it was addressed to. If =
you are not the intended recipient of this email you may not copy, forw=
ard, disclose or otherwise use it or any part of it in any form whatsoe=
ver. If you received this email in error please notify the sender by re=
plying and delete this message and any attachments without retaining a =
copy.
