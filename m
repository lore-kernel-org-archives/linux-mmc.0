From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: mmc: core: Delete an error message for a failed memory allocation
 in three functions
Date: Fri, 19 May 2017 11:39:12 +0200
Message-ID: <50f3c642-b866-27f3-1201-5490225116f4@users.sourceforge.net>
References: <b0978766-199a-942e-43d8-58d2a8a17e1a@users.sourceforge.net>
 <CAPDyKFqhNQdfr19195YfL7f4Jh0u6pGZ9QtSff0C6fe6R9wdjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqhNQdfr19195YfL7f4Jh0u6pGZ9QtSff0C6fe6R9wdjw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Burton <paul.burton@imgtec.com>, Shawn Lin <shawn.lin@rock-chips.com>, Tomas Winkler <tomas.winkler@intel.com>, Uri Yanai <uri.yanai@sandisk.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

> It's a nice cleanup. However I found one more occasion in mmc_test.c,
> please fix that and re-spin.

To which source code place does this feedback refer?

Does it mean that another message removal would make sense in the
function “__mmc_test_register_dbgfs_file”?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/core/mmc_test.c?h=v4.11#n3202

Regards,
Markus
