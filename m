From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/27] mmc: mvsdio: Remove redundant suspend and resume callbacks
Date: Fri, 27 Sep 2013 10:55:47 +0200
Message-ID: <CAPDyKFobK48HLh=u+RLoGLH2+tsK-FKCKFMUh0Y4oFLbXBAqRw@mail.gmail.com>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
	<1380207292-16968-10-git-send-email-ulf.hansson@linaro.org>
	<alpine.LFD.2.03.1309261136010.312@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:42666 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3I0Izs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 04:55:48 -0400
Received: by mail-vb0-f48.google.com with SMTP id w16so1625311vbf.21
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 01:55:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309261136010.312@syhkavp.arg>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>

On 26 September 2013 17:40, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 26 Sep 2013, Ulf Hansson wrote:
>
>> Suspend and resume of cards are handled by the protocol layer and
>> consequently the mmc_suspend|resume_host APIs are marked as deprecated.
>
> Having the protocol layer take care of card suspend is perfectly sound.
>
> However, what about host controllers?  Shouldn't they suspend themselves
> as well?  There is certainly potential for power saving by gating clocks
> to the host IP block or the like.
>

Hi Nicolas,

You are right, host drivers shall be responsible to handle power
saving operations, like clocks, power domains, pinctrls, etc. In many
cases I think using only runtime PM should satisfy a host driver's
need to perform the proper power saving.

For mvsdio, there were no host power save operations done in the
suspend/resume callbacks, which is why I removed the callbacks
entirely.

Kind regards
Ulf Hansson

>
> Nicolas
