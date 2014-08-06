From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: Sandisk MMC I/O errors
Date: Wed, 6 Aug 2014 09:15:24 +0800
Message-ID: <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
	<CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
	<CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
	<CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
	<CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
	<CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
	<CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
	<CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58137 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbaHFBP0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 21:15:26 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2335228wib.17
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 18:15:25 -0700 (PDT)
In-Reply-To: <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

from your log, maybe you should check the driver use byte mode or
sector mode to access eMMC.
Because the capacity of eMMC which you used is less or equal to 2GB.


2014-08-06 0:01 GMT+08:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> 2014-08-05 17:59 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
>> On Tue, Aug 5, 2014 at 12:54 PM, Jean-Michel Hautbois
>> <jean-michel.hautbois@vodalys.com> wrote:
>>
>>> I also tried the same pinmux conf on the Freescale repository, and it
>>> works correctly...
>>> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.10.17_1.0.0_ga
>>
>> I did not understand.
>>
>> Could you paste the working pinmux that worked for you?
>
> This is the same pinmux, but tested on 3.16 and on the Freescale kernel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
