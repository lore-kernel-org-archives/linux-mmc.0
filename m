From: Fabio Estevam <festevam@gmail.com>
Subject: Re: "Card stuck in programming state! __mmc_switch" problem on i.MX6
 + eMMC
Date: Mon, 29 Sep 2014 21:35:58 -0300
Message-ID: <CAOMZO5AKugbS_Q5CRPHZ-wSKD0NndxeJD6uQSYSxwCHyt+CZNw@mail.gmail.com>
References: <54184B19.4080909@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:56245 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbaI3Af7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 20:35:59 -0400
Received: by mail-la0-f44.google.com with SMTP id gi9so8850160lab.31
        for <linux-mmc@vger.kernel.org>; Mon, 29 Sep 2014 17:35:58 -0700 (PDT)
In-Reply-To: <54184B19.4080909@elsoft.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?David_M=C3=BCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi David,

On Tue, Sep 16, 2014 at 11:37 AM, David M=C3=BCller (ELSOFT AG)
<d.mueller@elsoft.ch> wrote:
> Hello
>
> I have a custom i.MX6Q based board with a Hynix eMMC chip attached to
> USDHC3. OS is a vanilla Linux 3.16 with some patches.
>
> Loading the iMX SDHC driver results in the following error:
>
> modprobe sdhci-esdhc-imx
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> mmc0: no vqmmc regulator found
> mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
> mmc0: BKOPS_EN bit is not set
> mmc0: Card stuck in programming state! __mmc_switch
> mmc0: error -110 whilst initialising MMC card
>
>
> Pin muxing looks ok nevertheless I played around with it to see if it
> makes a difference. I also tried the "Add delay between CMD6 and CMD1=
3
> for Sandisk eMMC cards" workaround previously mentioned on this list.
>
> As the whole thing is working under U-Boot as shown below, I tend to
> rule out soldering problems and non-functional hardware.
>
> =3D> ver
> U-Boot 2014.07-00045-g0955ecc-dirty (Aug 26 2014 - 12:47:21)
> =3D> mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
> =3D> mmc info
> Device: FSL_SDHC
> Manufacturer ID: 90
> OEM: 14a
> Name: H8G2d
> Tran Speed: 52000000
> Rd Block Len: 512
> MMC version 4.41
> High Capacity: Yes
> Capacity: 7.2 GiB
> Bus Width: 8-bit
>
>
> Any idea what is going wrong?
> Has anybody a Hynix eMMC working under Linux?

I remember having similar issues and they were fixed by this series:
http://www.spinics.net/lists/linux-mmc/msg28260.html

You can try linux-next as this series is already applied there already.
