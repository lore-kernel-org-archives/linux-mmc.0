From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: atmel-mci: add runtime pm support
Date: Tue, 4 Nov 2014 17:00:37 +0100
Message-ID: <CAPDyKFqAZTT2mOUpKbM74ACtke=EPOCRDKj95X6YZikNxbTLvQ@mail.gmail.com>
References: <1414641641-32691-1-git-send-email-wenyou.yang@atmel.com>
	<CAPDyKFpVjoyNWpuZJ=k=nvcZkfarJtJ9oNAVjRBvmqZKuedxfA@mail.gmail.com>
	<20141104131459.GR20550@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:63387 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbaKDQAj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 11:00:39 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so7709589qgd.8
        for <linux-mmc@vger.kernel.org>; Tue, 04 Nov 2014 08:00:38 -0800 (PST)
In-Reply-To: <20141104131459.GR20550@ldesroches-Latitude-E6320>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <chris@printf.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 4 November 2014 14:14, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> On Tue, Nov 04, 2014 at 11:05:56AM +0100, Ulf Hansson wrote:
>> On 30 October 2014 05:00, Wenyou Yang <wenyou.yang@atmel.com> wrote:
>> > Add runtime pm support to atmel mci controller.
>> > Use runtime pm APIs to enable/disable atmel mci's clock.
>> > Use runtime autosuspend APIs to enable auto suspend delay.
>> >
>> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
>> Ludovic, any objections to this one?
>
> I am not a PM runtime guru, since you have reviewed the first version,
> it is ok for me :)

Thanks! Applied for next.

Kind regards
Uffe
