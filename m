From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] mmc: block: Fix SD card stop cmd response type
Date: Thu, 25 Sep 2014 11:20:12 +0200
Message-ID: <CAPDyKFr4YuCyW9DhbQRyFDTkMdm1meK96z7x7-gUvRCvy0U+qg@mail.gmail.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
	<1411502430-25535-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:56386 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbaIYJUN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Sep 2014 05:20:13 -0400
Received: by mail-qg0-f52.google.com with SMTP id j5so6204350qga.25
        for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2014 02:20:13 -0700 (PDT)
In-Reply-To: <1411502430-25535-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Nowhere in the SD Association Specifications does
> it state that the stop command has an R1 response
> type.  It is always R1B.  Change accordingly.

It depends on how detailed you read the spec. :-)

First, R1B is the same as R1, but with optional busy signalling on DAT0.

Just reading the table listing CMDS their related response types,
confirms what you are saying. CMD12 has an R1B.

Though, going into the details of the "Timing" section where this is
clearly visualized in diagrams, you realize there are no busy
signalling associated with a DATA READ, only for DATA WRITE. It is
also indicated in earlier sections of the spec when "DATA READ/WRITE
sequences are described", but I think the "Timing" section describes
this the best.

Kind regards
Uffe
