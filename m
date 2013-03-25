From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 2/3] block: Add API for urgent request handling
Date: Mon, 25 Mar 2013 06:40:07 -0600
Message-ID: <20130325124007.GH22327@kernel.dk>
References: <1364202178-8936-1-git-send-email-tlinder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364202178-8936-1-git-send-email-tlinder@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tanya Brokhman <tlinder@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Alex.Lemberg@sandisk.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 25 2013, Tanya Brokhman wrote:
> This patch add support in block & elevator layers for handling
> urgent requests. The decision if a request is urgent or not is taken
> by the scheduler. Request is marked as urgent in cmd_flags (by the
> scheduler) with a new flag - REQ_URGENT.
> Urgent request notification is passed to the underlying
> block device driver (eMMC for example). Block device driver may decide to
> interrupt the currently running low priority request to serve the new
> urgent request. By doing so READ latency is greatly reduced in read&write
> collision scenarios.
> 
> Note that if the current scheduler doesn't implement the urgent request
> mechanism, this code path is never activated.

I really don't like this out-of-band mechanism. Lets say there is an
urgent request, the IO scheduler would put that at the head of the
queue. So the first time the driver fetches a request, it'll see this
urgent request. A driver that has support for this, would check the head
of queue everytime its request_fn was invoked. There's no need to add a
elevator_is_urgent_fn() and ->notified_urgent.

-- 
Jens Axboe
