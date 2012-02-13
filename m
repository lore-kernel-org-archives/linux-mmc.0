From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Tue, 14 Feb 2012 02:07:35 +0530
Message-ID: <CAKLKtzdr68J7wF6m9wpCaXh3_XnL6y9tid2g4yzwxVVPgLndGA@mail.gmail.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	<m2mx8y6ls1.fsf@bob.laptop.org>
	<CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
	<4F2F649E.2010106@samsung.com>
	<CAKLKtzcAqJVDTZFYpijicWStr7m76Quv2ic8hRZp+X_Wmd-bFQ@mail.gmail.com>
	<m2vcndks0m.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45229 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757971Ab2BMUhh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2012 15:37:37 -0500
Received: by wgbdt10 with SMTP id dt10so5246907wgb.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2012 12:37:35 -0800 (PST)
In-Reply-To: <m2vcndks0m.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 12 February 2012 02:27, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Feb 06 2012, Saugata Das wrote:
>> Thanks for the info. Perhaps the initial MMC-4.5 device samples do n=
ot
>> implement this command well. Yes, this feature is good to have in th=
e
>> kernel. I shall wait for some more comments on the proposed
>> implementation before submitting the patch.
>
> I'm not very excited about merging features that offer no concrete
> benefit, because it just grows the kernel (and list of places where b=
ugs
> can occur) for no benefit. =A0So, it would be great if we could find =
a
> device that actually implements these contexts in a way that provides
> a performance benefit, to prove that adding the code is worthwhile.
>

Completely agree with you. The purpose of proposing this
implementation under [RFC] was to trigger some discussion on how this
feature should be implemented.

> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
