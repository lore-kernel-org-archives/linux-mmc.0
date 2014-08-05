From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Tue, 5 Aug 2014 17:20:25 +0200
Message-ID: <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:45551 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaHEPUl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 11:20:41 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so766793oag.26
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 08:20:40 -0700 (PDT)
In-Reply-To: <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-05 17:13 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
> On Tue, Aug 5, 2014 at 11:26 AM, Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com> wrote:
>> Hi all,
>>
>> I have a custom board based on a i.MX6 SoC and it has a Sandisk eMMC
>> (SDIN5D1-2G).
>> When booting a vanilla kernel, I get lots of I/O errors.
>> Before investigating, I would like to know if this is a known issue.
>>
>> Here is the full dmesg :
>>
>> [    1.346762] mmcblk1: mmc1:0001 SEM02G 1.82 GiB
>> [    1.350142] mmcblk1boot0: mmc1:0001 SEM02G partition 1 1.00 MiB
>> [    1.354901] mmcblk1boot1: mmc1:0001 SEM02G partition 2 1.00 MiB
>> [    1.359643] mmcblk1rpmb: mmc1:0001 SEM02G partition 3 128 KiB
>> [    1.366291] mmcblk1: error -84 transferring data, sector 0, nr 8,
>> cmd response 0x900, card status 0xb00
>
> Just tested on a imx6q-sabresd running kernel 3.16 and it detects the
> eMMC without errors:
>
> mmcblk1: mmc2:0001 SEM08G 7.39 GiB
> mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
> mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
> mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
>
> In imx6qdl-sabresd.dtsi we have:
>
> &usdhc4 {
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_usdhc4>;
>     bus-width = <8>;
>     non-removable;
>     no-1-8-v;
>     status = "okay";
> };
>
> Also, please check your esdhc pinmux settings.

Thanks. Here are my settings (I used the imx6qdl-sabresd as an example) :

pinctrl_usdhc4: usdhc4grp {
  fsl,pins = <
    MX6QDL_PAD_SD4_CMD__SD4_CMD 0x17059
    MX6QDL_PAD_SD4_CLK__SD4_CLK 0x10059
    MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
    MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
    MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
    MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
    MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
    MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
    MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
    MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
  >;
};

&usdhc4 {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_usdhc4>;
    bus-width = <8>;
    non-removable;
    no-1-8-v;
    status = "okay";
};

JM
