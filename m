From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Sandisk MMC I/O errors
Date: Tue, 5 Aug 2014 12:13:08 -0300
Message-ID: <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48133 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaHEPNL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 11:13:11 -0400
Received: by mail-lb0-f173.google.com with SMTP id p9so845515lbv.18
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 08:13:09 -0700 (PDT)
In-Reply-To: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Aug 5, 2014 at 11:26 AM, Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com> wrote:
> Hi all,
>
> I have a custom board based on a i.MX6 SoC and it has a Sandisk eMMC
> (SDIN5D1-2G).
> When booting a vanilla kernel, I get lots of I/O errors.
> Before investigating, I would like to know if this is a known issue.
>
> Here is the full dmesg :
>
> [    1.346762] mmcblk1: mmc1:0001 SEM02G 1.82 GiB
> [    1.350142] mmcblk1boot0: mmc1:0001 SEM02G partition 1 1.00 MiB
> [    1.354901] mmcblk1boot1: mmc1:0001 SEM02G partition 2 1.00 MiB
> [    1.359643] mmcblk1rpmb: mmc1:0001 SEM02G partition 3 128 KiB
> [    1.366291] mmcblk1: error -84 transferring data, sector 0, nr 8,
> cmd response 0x900, card status 0xb00

Just tested on a imx6q-sabresd running kernel 3.16 and it detects the
eMMC without errors:

mmcblk1: mmc2:0001 SEM08G 7.39 GiB
mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB

In imx6qdl-sabresd.dtsi we have:

&usdhc4 {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_usdhc4>;
    bus-width = <8>;
    non-removable;
    no-1-8-v;
    status = "okay";
};

Also, please check your esdhc pinmux settings.
