From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into the driver
Date: Tue, 22 Jan 2013 10:53:42 +0100
Message-ID: <CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
	<1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
	<20130122090000.GH6857@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44914 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab3AVJxn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 04:53:43 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so11519018ieb.28
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jan 2013 01:53:42 -0800 (PST)
In-Reply-To: <20130122090000.GH6857@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Jan 22, 2013 at 10:00 AM, Lee Jones <lee.jones@linaro.org> wrote:

>> From: Lee Jones <lee.jones@linaro.org>
>>
>> There are currently two instances of the ios_handler being used.
>> Both of which mearly toy with some regulator settings. Now there
>> is a GPIO regulator API, we can use that instead, and lessen the
>> per platform burden. By doing this, we also become more Device
>> Tree compatible.
>
> Russell,
>
> Why is this patch in your tree with Ulf as the Author?

This is because of the way Russell's patch tracker works, it sets
Author: to the name of the person using the patch tracker and
discards the From: field in the beginning of the patch which
git am will conversely respect.

If you need authorship preserved each author need to submit the
patch to the patch tracker individually, as author.

Yours,
Linus Walleij
