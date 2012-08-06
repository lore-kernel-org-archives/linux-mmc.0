From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC/PATCH 2/2] block: Adding ROW scheduling algorithm
Date: Mon, 06 Aug 2012 12:35:19 -0400
Message-ID: <x49wr1cdlmg.fsf@segfault.boston.devel.redhat.com>
References: <1344166241-18708-1-git-send-email-tlinder@codeaurora.org>
	<1344166241-18708-3-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1344166241-18708-3-git-send-email-tlinder@codeaurora.org>
	(Tatyana Brokhman's message of "Sun, 5 Aug 2012 14:30:41 +0300")
Sender: linux-doc-owner@vger.kernel.org
To: Tatyana Brokhman <tlinder@codeaurora.org>
Cc: axboe@kernel.dk, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Tatyana Brokhman <tlinder@codeaurora.org> writes:

> This patch adds the implementation of a new scheduling algorithm - ROW.
> The policy of this algorithm is to prioritize READ requests over WRITE
> as much as possible without starving the WRITE requests.

Perhaps you could start off by describing the workload, and describing
why the existing I/O schedulers do not perform well.  Then, you could go
on to say why you feel that the existing I/O schedulers could not be
modified to perform better under your workload, and wrap the whole thing
up with some convincing performance numbers (including your testing
procedures so others could verify your work independently).

Without the above, I think you'll have a difficult time getting yet
another I/O scheduler merged into the kernel.

Cheers,
Jeff
