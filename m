From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 1/3] block: Add test-iosched scheduler
Date: Tue, 31 Jul 2012 17:46:22 +0200
Message-ID: <5017FDCE.5030700@kernel.dk>
References: <n> <1343744710-31700-2-git-send-email-merez@codeaurora.org> <09c3a301ad7ca4fa396c4d00615312c1.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <09c3a301ad7ca4fa396c4d00615312c1.squirrel@www.codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 07/31/2012 04:36 PM, merez@codeaurora.org wrote:
> Hi Jens,
> 
> Do you have comments on this patch?
> Can we push it to kernel 3.6 version?

I have questions - what is this good for? In other words, explain to me
why this is useful code. And in particular why this cannot be done from
userspace with bsg and block tracing?

IOW, I'm dubious as to whether a new _io scheduler_ is the correct
solution to the problem you have at hand.

-- 
Jens Axboe

