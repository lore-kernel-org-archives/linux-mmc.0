From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Tue, 5 Aug 2014 17:54:01 +0200
Message-ID: <CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
 <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
 <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com> <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:62469 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbaHEPyS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 11:54:18 -0400
Received: by mail-oi0-f46.google.com with SMTP id i138so734618oig.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 08:54:16 -0700 (PDT)
In-Reply-To: <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-05 17:44 GMT+02:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> 2014-08-05 17:35 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
>> On Tue, Aug 5, 2014 at 12:20 PM, Jean-Michel Hautbois
>> <jean-michel.hautbois@vodalys.com> wrote:
>>
>>> Thanks. Here are my settings (I used the imx6qdl-sabresd as an example) :
>>>
>>> pinctrl_usdhc4: usdhc4grp {
>>>   fsl,pins = <
>>>     MX6QDL_PAD_SD4_CMD__SD4_CMD 0x17059
>>>     MX6QDL_PAD_SD4_CLK__SD4_CLK 0x10059
>>>     MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
>>>     MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
>>>     MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
>>>     MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
>>>     MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
>>>     MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
>>>     MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
>>>     MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
>>>   >;
>>> };
>>>
>>> &usdhc4 {
>>>     pinctrl-names = "default";
>>>     pinctrl-0 = <&pinctrl_usdhc4>;
>>>     bus-width = <8>;
>>>     non-removable;
>>>     no-1-8-v;
>>>     status = "okay";
>>> };
>>
>> Which kernel version are using? Does your board use the exact same
>> pins as mx6qsabresd for the eMMC?
>
> The kernel is 3.16, the pins are not exactly the same, as I have a
> RST_n pin connected in my case, and not on the sabresd, but everything
> else is the same (if I read mly schematics correctly)...
>
> JM

I also tried the same pinmux conf on the Freescale repository, and it
works correctly...
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.10.17_1.0.0_ga
