From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: Sandisk MMC I/O errors
Date: Tue, 5 Aug 2014 18:01:39 +0200
Message-ID: <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
 <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
 <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
 <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
 <CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com> <CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41570 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbaHEQBz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 12:01:55 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so840266obc.4
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 09:01:54 -0700 (PDT)
In-Reply-To: <CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-08-05 17:59 GMT+02:00 Fabio Estevam <festevam@gmail.com>:
> On Tue, Aug 5, 2014 at 12:54 PM, Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com> wrote:
>
>> I also tried the same pinmux conf on the Freescale repository, and it
>> works correctly...
>> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.10.17_1.0.0_ga
>
> I did not understand.
>
> Could you paste the working pinmux that worked for you?

This is the same pinmux, but tested on 3.16 and on the Freescale kernel.
