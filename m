From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Move files to core
Date: Thu, 8 Dec 2016 14:47:26 +0200
Message-ID: <6ca1c5b1-ed43-47b8-c6eb-64f58b11d813@intel.com>
References: <1481195892-31779-1-git-send-email-ulf.hansson@linaro.org>
 <e0cab491-2902-1931-a14b-75ed7ac3e8af@intel.com>
 <CAPDyKFphV0SFLfnL19EfTLH2ZuGpHpP991xMhSq1O_J500BNTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:43420 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbcLHMwf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 07:52:35 -0500
In-Reply-To: <CAPDyKFphV0SFLfnL19EfTLH2ZuGpHpP991xMhSq1O_J500BNTw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 08/12/16 14:21, Ulf Hansson wrote:
> On 8 December 2016 at 12:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 08/12/16 13:18, Ulf Hansson wrote:
>>> Once upon a time it made sense to keep the mmc block device driver and its
>>> related code, in a separate directory. Over time, more an more interfaces
>>> and structures have been exported by the core layer to outsiders. This to
>>> allow the mmc block device driver to do its job. In other words, the
>>> relationship between the block code and the core code has become closer.
>>>
>>> Let's not continue this path, but instead let's join the two directories.
>>> Simply by moving the block files into the core directory, lots of clean ups
>>> can be made, but more importantly, this change should also enables us
>>> remove unnecessary exported interfaces.
>>
>> Don't you still need to export things if they are separate modules?
> 
> Yes, right! Perhaps I was a bit too vague in my change-log.
> 
> I aim to slim down generic mmc headers in include/linux/mmc/* as to
> achieve the goal of only providing interfaces/structures to outsiders
> which they are allowed to use. Currently it's it too easy to abuse the
> mmc interfaces.

Then would another option be to have the mmc block driver reach over and
include what it needs?
e.g.

	#include "../core/blkonly.h"

> 
> BTW, regarding your eMMC CMDQ series, that can easily be re-based on
> top of this change as git takes good care of files being renamed.

Yes, re-basing is normal :-)

