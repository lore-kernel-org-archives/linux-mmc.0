From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Wed, 12 Oct 2011 13:33:47 +0300
Message-ID: <4E956D0B.8060803@intel.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com> <CACRpkdb5pn=q+hQSsrTgKbCvuKR83vHn1iAfvzMFXQeAgv--+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:64249 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab1JLKdv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Oct 2011 06:33:51 -0400
In-Reply-To: <CACRpkdb5pn=q+hQSsrTgKbCvuKR83vHn1iAfvzMFXQeAgv--+Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>

On 12/10/11 12:41, Linus Walleij wrote:
> On Tue, Oct 11, 2011 at 4:06 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> 
>> The patch "mmc: core: move ->request() call from atomic context",
>> is the reason to why this change is possible. This simplifies the
>> error handling code execution path quite a lot and potentially also
>> fixes some error handling hang problems.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> Adrian do you agree with this?

Yes

> 
> To me it looks correct,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

