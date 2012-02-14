From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: mmc_test
Date: Tue, 14 Feb 2012 13:36:28 +0530
Message-ID: <CANYdXnpCYG3a_LxjtK=dXCGx8CSuM6O0TOze=SuU44Qu6AsmNA@mail.gmail.com>
References: <CAMKhXh=5eymTCzDPRd0ipxQN5z4ZB2BSoTxwy1C+v7iP8T_BiQ@mail.gmail.com>
	<4F3A125D.8000603@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42580 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab2BNIG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 03:06:29 -0500
Received: by iacb35 with SMTP id b35so5767105iac.19
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2012 00:06:29 -0800 (PST)
In-Reply-To: <4F3A125D.8000603@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shridhar Rasal <shri.rasal@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,
The mmc_test runs fine for SD cards as well. As Adrian said, if the
block is un-binded correctly, it should work for any card.
Another point , may not be worthy here is modification in make file
mmc_test.o needs to compiled before block.o. Sometimes I have seen
cases where this has solved the issue.

On Tue, Feb 14, 2012 at 1:20 PM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
>
> On 14/02/12 08:41, Shridhar Rasal wrote:
> > [sorry for spamming you]
> >
> > Dear Adrian,
> >
> > I am working on K3.1.
> > I am trying to run mmc_test on my set-up. I have added mmc_test as =
a driver.
> > But sysfs entries(test/testlist) are getting created only for any o=
f SDIO host.
>
> mmc_test will not work if mmc_block has already been given all the
> MMC devices.
>
> You can always switch between mmc_test and mmc_block by
> unbinding / binding e.g.
>
>
> # ls -al /sys/bus/mmc/drivers/mmcblk
> drwxr-xr-x =C2=A0 =C2=A02 root =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0 Jan =C2=A01 00:00 .
> drwxr-xr-x =C2=A0 =C2=A04 root =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0 Jan =C2=A01 00:00 ..
> --w------- =C2=A0 =C2=A01 root =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04096 Jan =C2=A01 00:01 bind
> lrwxrwxrwx =C2=A0 =C2=A01 root =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0 Jan =C2=A01 00:01 mmc0:0001 ->
> ../../../../devices/platform/mmci-omap-hs.1/mmc_host/mmc0/mmc0:0001
> --w------- =C2=A0 =C2=A01 root =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04096 Jan =C2=A01 00:01 uevent
> --w------- =C2=A0 =C2=A01 root =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04096 Jan =C2=A01 00:01 unbind
>
> # echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
>
> # echo mmc0:0001 > /sys/bus/mmc/drivers/mmc_test/bind
> [ =C2=A0128.221313] mmc_test mmc0:0001: Card claimed for testing.
>
>
> >
> > I digged =C2=A0further and found that,
> > 1. =C2=A0mmc_test_probe is invoked only in case of SDIO and not for=
 other hosts.
> > 2. =C2=A0this is because of from mmc_bus_probe( ), only for SDIO ho=
st -
> > mmc_test_probe () invoked and for other hosts - mmc_blk_probe () in=
voked.
> >
> >
> > - What can be reason for this?
> > - Am I missing some patches?
> >
> > Also, please let me know, where can I post such mmc related queries=
=2E
>
> MMC mailing list:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://vger.kernel.org/vger-lists.html#lin=
ux-mmc
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml




--
regards,
Shashidhar Hiremath
