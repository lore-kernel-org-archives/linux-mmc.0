From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: mmc : sdhci_do_start_signal_voltage_switch
Date: Tue, 6 Oct 2015 15:54:05 +0530
Message-ID: <CAHhAz+gGYiFNrb_Hegqu+AqGCVRHGa6Qv56EGCBskRvFY2-aEw@mail.gmail.com>
References: <CAHhAz+jUKPwVFQgkrdkX2gM1fFecZWJJofV49jE+Z3gYEpQimQ@mail.gmail.com>
	<CAPDyKFp4BUcvew887_pFit8RsQRqmM1V2zEpZrxT0w9BsOhfMQ@mail.gmail.com>
	<CAHhAz+i8923qvxi8pT3MLr2wHb8PgapbV9RCA_L-rWzxq4HcCA@mail.gmail.com>
	<CAPDyKFrzx6ZLKSNnFe1LOsw4VU2sWBc6bm75y+OQtjjafwhchw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35394 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbJFKYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 06:24:06 -0400
Received: by igbkq10 with SMTP id kq10so80940479igb.0
        for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2015 03:24:05 -0700 (PDT)
In-Reply-To: <CAPDyKFrzx6ZLKSNnFe1LOsw4VU2sWBc6bm75y+OQtjjafwhchw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Tue, Oct 6, 2015 at 1:09 PM, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
>
> On 6 October 2015 at 08:32, Muni Sekhar <munisekharrms@gmail.com> wro=
te:
> > Hi Uffe,
> > Could you please explain about the way to add a time suitable for m=
y case?
> >
>
> Please, don't top-post!
>
> Did you consider the regulator option?
I noticed the =E2=80=9Cno vqmmc regulator found=E2=80=9D message.

[    2.143556] mmc0: no vqmmc regulator found
[    2.143559] mmc0: no vmmc regulator found

I don=E2=80=99t know how to model this IO voltage through a regulator. =
Does it
need any additional hardware?
>
>
> Regarding how to add a suitable time, I haven't yet figured out how t=
o
> easiest solve do that, but there are a few options.
>
> Kind regards
> Uffe




--
Thanks,
Sekhar
