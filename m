From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Fixup error handling for dma
Date: Mon, 5 Dec 2011 18:00:08 +0100
Message-ID: <4EDCF898.7080604@stericsson.com>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>	<20111130222139.GW9581@n2100.arm.linux.org.uk> <CACRpkdacJxbFvSuXTsxtjZVbeTaJwNN4xy7-rvpa0U0Z4pDE_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:53359 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932516Ab1LERAp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 12:00:45 -0500
In-Reply-To: <CACRpkdacJxbFvSuXTsxtjZVbeTaJwNN4xy7-rvpa0U0Z4pDE_g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, Per FORLIN <per.forlin@stericsson.com>

Linus Walleij wrote:
> On Wed, Nov 30, 2011 at 11:21 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>=20
>>>       if (!cmd->data || cmd->error) {
>>> -             if (host->data)
>>> +             if (host->data) {
>>> +                     /* Terminate the DMA transfer */
>>> +                     if (dma_inprogress(host))
>>> +                             mmci_dma_data_error(host);
>> Doesn't this leave the DMA buffers mapped?

Correct, but it will be handled in post_request function.

>=20
> Yep it needs an mmci_dma_unmap() call too AFAICT,
> Ulf will you update?

Actually it's needs only dma_unmap_sg, but as stated this should be=20
handled in mmci_post_request.

By, the way - I spoke to Per F=F6rlin who implemented the pre_request a=
nd=20
post_request functions; we will soon push some clean-up patches for=20
improved error handling and how to manage the cookie better. Right now=20
it is kind of hard to follow the error path, I think. We hope this shal=
l=20
be improved then.

Although it should have nothing to do with this patch directly, since=20
this is a bugfix only.

BR
Ulf Hansson
