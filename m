From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc : Use wait_for_completion_timeout() instead of
 wait_for_completion in case of write.
Date: Tue, 20 Sep 2011 23:22:38 +0900
Message-ID: <CAKYAXd8WiakFVy_ykpbw-Eq+XDgX0NECtJZFDy3WzxtNfJmdkw@mail.gmail.com>
References: <1316359301-2263-1-git-send-email-linkinjeon@gmail.com>
	<4E78433F.2050900@stericsson.com>
	<CA+Wuu-vAx8PkvPgy5mR5Bcg6e+q6Z3XOZtTGwNZgCW4HCrX5KA@mail.gmail.com>
	<CAKYAXd9bmw12By6StTL_MRzAGsgG9BOfcvs=TA-nRu_uxMzOcw@mail.gmail.com>
	<CA+Wuu-sK6B_k0+sG_p4JRuHOwO_HVCpNksg-9_TdpzXRS7y0xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35490 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1ITOWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2011 10:22:39 -0400
In-Reply-To: <CA+Wuu-sK6B_k0+sG_p4JRuHOwO_HVCpNksg-9_TdpzXRS7y0xA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Murali Krishna Palnati <palnati.muralikrishna@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2011/9/20 Murali Krishna Palnati <palnati.muralikrishna@gmail.com>:
> On Tue, Sep 20, 2011 at 4:05 PM, NamJae Jeon <linkinjeon@gmail.com> w=
rote:
>> yes, I knew. But if card keep holding busy line(data 0) in the middl=
e
>> of DMA operation(multi blocks write), =C2=A0host driver layer can no=
t know
>> card status in this situation.
>
> The host driver shall start a software timer and indpendently needs t=
o
> watch out for the expiry of the timeout. If the host doesn't hear bac=
k
> from the
> controller/DMA engine even after waiting for the specified timeout,
> then the timer handler that gets invoked can then do the necessary
> cleanup and
> inform the MMC core layer that the request failed. Does this sound fe=
asible?
>

It may be no good choice that sw timer is on host driver. also I don't
know what is different.
It is the same as the ata driver's dma_map_sg.
dma_map_sg is repectively called in mmc host driver. but it is being
processed in ata core of ata driver.
because it is common routine, ata core have called it instead of host d=
river.
if it is processed in mmc core, there is no need to modify several
hosts.(except dma controller reset)
