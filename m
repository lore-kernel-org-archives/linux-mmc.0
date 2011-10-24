From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 10:36:32 +0100
Message-ID: <20111024093632.GH9893@n2100.arm.linux.org.uk>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com> <20111021173637.GG21648@n2100.arm.linux.org.uk> <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com> <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40847 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab1JXJgn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 05:36:43 -0400
Content-Disposition: inline
In-Reply-To: <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Sun, Oct 23, 2011 at 02:31:39AM +0200, Sebastian Rasmussen wrote:
> I guess the patch would appeal more to Russell if mmci_runtime_suspend()
> only cleared MCIMask0/SDI_MASK0 and MCIClock/SDI_CLKCR and left
> MCIPower/SDI_PWR unchanged. It may be the case that the signal direction
> bits need to be cleared for the ST-Ericsson PL180, but I haven't yet verified
> this on my Snowball dev board yet.

There's also the issue that the specs call for the clock to run after
a command has completed for a certain number of cycles, and that the
clock must continue to run until the card reports not-busy after a
programming or erase cycle has completed - that can be long after the
previous command has 'completed'.
