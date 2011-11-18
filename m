From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Fri, 18 Nov 2011 11:06:44 +0200
Message-ID: <CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43997 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab1KRJHG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 04:07:06 -0500
Received: by yenq3 with SMTP id q3so2209103yen.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2011 01:07:05 -0800 (PST)
In-Reply-To: <WC20111118085327.010279@terrafix.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Joe,

On Fri, Nov 18, 2011 at 10:53 AM, Joe Woodward <jw@terrafix.co.uk> wrote:
> Are these workarounds expected to be enough for runtime PM to just "work"?

It definitely works for 12xx, and with Daniel's recent work merged I
think it also works fine for the sd8686 (Daniel, PCMIIW).

Ohad.
