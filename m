From: "Tanya Brokhman" <tlinder@codeaurora.org>
Subject: Re: [PATCH v5 1/3] block: Add support for reinsert a dispatched req
Date: Fri, 29 Mar 2013 22:07:12 +0300
Message-ID: <ac6067989f4390aee844926736e8c421.squirrel@www.codeaurora.org>
References: <1364202150-8776-1-git-send-email-tlinder@codeaurora.org>
    <20130325123410.GG22327@kernel.dk>
    <d6658b60b7e09376cfcf692dc54ac922.squirrel@www.codeaurora.org>
    <20130328184922.GE19488@kernel.dk>
Reply-To: tlinder@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130328184922.GE19488@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: tlinder@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, alex.lemberg@sandisk.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jens

>
> I said practically the same, not exactly the same! In any case, the
> point is that you could reuse the exact same infrastructure for this,
> instead of literally duplicating everything. Have some helper that does
> the grunt of the work, pass in whether or not you want the existing
> requeue event, or a reinsert event.
>

 Thank you for the input. Will do and upload a new patch.

Thanks,
Tanya Brokhman
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
