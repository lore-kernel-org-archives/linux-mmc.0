From: Murali Krishna Palnati <palnati.muralikrishna@gmail.com>
Subject: Re: [PATCH] mmc : Use wait_for_completion_timeout() instead of
 wait_for_completion in case of write.
Date: Tue, 20 Sep 2011 14:58:52 +0530
Message-ID: <CA+Wuu-vAx8PkvPgy5mR5Bcg6e+q6Z3XOZtTGwNZgCW4HCrX5KA@mail.gmail.com>
References: <1316359301-2263-1-git-send-email-linkinjeon@gmail.com>
	<4E78433F.2050900@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E78433F.2050900@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 20, 2011 at 1:09 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
> Namjae Jeon wrote:
>>
>> host controller can not rise timeout interrupt in write not read in DMA status. because host can just know whether card is finish to program to use busy line. If unstable card is keep holding busy line while writing using DMA.
>> hang problem happen by wait_for_completion. so I think that mmc driver need some exception to avoid this problem.
>> I suggest to use wait_for_completion_timeout instead of wait_for_completion.
>>
>
> I see what you are trying to solve, but you can never calculate the timeout for this type of operation in such a way. Your timeout involves the entire data write operation, how can you ever know how long this will take?
>
> I think a much better approach is to make you host driver not using "busy signaling" (if that is possible), thus when the DMA job is done call mmc_request_done to finalize the data transfer. The mmc framework will then send a CMD13 (SEND_STATUS) to make sure the data is written before issuing the next request.
>
> BR
> Ulf Hansson


To add to what Hansson mentioned, the timeout mechanism should not be
implemented at the MMC core layer. If the core layer simply times out
like this, the host controller driver still remains in the same state
which is not right. If such a timeout mechanism is needed, it is best
to implement in the host controller driver layer and inform the core
layer by calling mmc_request_done() when the time out happens. This
will also give a chance to the host controller driver to do any
required clean up at the controller layer so that it is in a known
good state to handle further requests from the core layer.

Regards,
Murali Krishna
