From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: mmc : sdhci_do_start_signal_voltage_switch
Date: Fri, 9 Oct 2015 15:21:25 +0530
Message-ID: <CAHhAz+jcpNdNdnnSkVrFR9fjV59Os-JV4TD0yRd7xq29WjxTtA@mail.gmail.com>
References: <CAHhAz+jUKPwVFQgkrdkX2gM1fFecZWJJofV49jE+Z3gYEpQimQ@mail.gmail.com>
	<CAPDyKFp4BUcvew887_pFit8RsQRqmM1V2zEpZrxT0w9BsOhfMQ@mail.gmail.com>
	<CAHhAz+i8923qvxi8pT3MLr2wHb8PgapbV9RCA_L-rWzxq4HcCA@mail.gmail.com>
	<CAPDyKFrzx6ZLKSNnFe1LOsw4VU2sWBc6bm75y+OQtjjafwhchw@mail.gmail.com>
	<CAHhAz+gGYiFNrb_Hegqu+AqGCVRHGa6Qv56EGCBskRvFY2-aEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34860 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965265AbbJIJv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 05:51:26 -0400
Received: by iofl186 with SMTP id l186so4184862iof.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 02:51:25 -0700 (PDT)
In-Reply-To: <CAHhAz+gGYiFNrb_Hegqu+AqGCVRHGa6Qv56EGCBskRvFY2-aEw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Tue, Oct 6, 2015 at 3:54 PM, Muni Sekhar <munisekharrms@gmail.com> w=
rote:
> On Tue, Oct 6, 2015 at 1:09 PM, Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
>>
>> On 6 October 2015 at 08:32, Muni Sekhar <munisekharrms@gmail.com> wr=
ote:
>> > Hi Uffe,
>> > Could you please explain about the way to add a time suitable for =
my case?
>> >
>>
>> Please, don't top-post!
>>
>> Did you consider the regulator option?
> I noticed the =E2=80=9Cno vqmmc regulator found=E2=80=9D message.
>
> [    2.143556] mmc0: no vqmmc regulator found
> [    2.143559] mmc0: no vmmc regulator found
>
> I don=E2=80=99t know how to model this IO voltage through a regulator=
=2E Does it
> need any additional hardware?
>>
>>
>> Regarding how to add a suitable time, I haven't yet figured out how =
to
>> easiest solve do that, but there are a few options.
If you have figured out then could you please share that option? I
would like to try that.

>>
>> Kind regards
>> Uffe
>
>
>
>
> --
> Thanks,
> Sekhar



--
Thanks,
Sekhar
