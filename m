From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH v2] wait while adding MMC host to ensure root mounts
Date: Sat, 13 Apr 2013 16:52:28 +0400
Message-ID: <1365857548.9806.64.camel@host5.omatika.ru>
References: <1363223183-3772-1-git-send-email-ynvich@gmail.com>
	 <1363224194-7366-1-git-send-email-ynvich@gmail.com>
	 <87620jmkoe.fsf@octavius.laptop.org>
	 <CAPDyKFp27MUOjhydLXf92vN3cua=XcX4oTJnMGfOJPpBhtwM8Q@mail.gmail.com>
	 <87ppylf429.fsf@octavius.laptop.org>
	 <1365850153.9806.59.camel@host5.omatika.ru>
	 <CAPDyKFrF8pmo7mfa_1Vi2n=JBFd1h+VULQ1hJB75=DmNx0erdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:56617 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3DMMwd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 13 Apr 2013 08:52:33 -0400
In-Reply-To: <CAPDyKFrF8pmo7mfa_1Vi2n=JBFd1h+VULQ1hJB75=DmNx0erdw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Namjae Jeon <linkinjeon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2013-04-13 at 13:56 +0200, Ulf Hansson wrote:
> 
> Den 13 apr 2013 12:49 skrev "Sergey Yanovich" <ynvich@gmail.com>:
> > A possible solution is to make card a separate device (now only the
> host
> > is a device). In this case, the probing could be done asynchronously
> > without breaking the assumption in prepare_namespace().
> 
> Actually the card is already a separate device, which I connected to
> the mmc bus.

Great. I failed to see that.

> It is an interesting idea, but the problem is that the card device is
> only created and added on the fly when a card has been properly
> detected.

If we include 'detecting' in 'probing' and then do 'probing'
asynchronously, we will neither have race condition, nor boot time
regression.

