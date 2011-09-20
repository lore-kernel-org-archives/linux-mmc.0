From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc : Use wait_for_completion_timeout() instead of
 wait_for_completion in case of write.
Date: Tue, 20 Sep 2011 19:35:08 +0900
Message-ID: <CAKYAXd9bmw12By6StTL_MRzAGsgG9BOfcvs=TA-nRu_uxMzOcw@mail.gmail.com>
References: <1316359301-2263-1-git-send-email-linkinjeon@gmail.com>
	<4E78433F.2050900@stericsson.com>
	<CA+Wuu-vAx8PkvPgy5mR5Bcg6e+q6Z3XOZtTGwNZgCW4HCrX5KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45872 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab1ITKfK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2011 06:35:10 -0400
In-Reply-To: <CA+Wuu-vAx8PkvPgy5mR5Bcg6e+q6Z3XOZtTGwNZgCW4HCrX5KA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Murali Krishna Palnati <palnati.muralikrishna@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2011/9/20 Murali Krishna Palnati <palnati.muralikrishna@gmail.com>:
> On Tue, Sep 20, 2011 at 1:09 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>>
>> Namjae Jeon wrote:
>>>
>>> host controller can not rise timeout interrupt in write not read in DMA status. because host can just know whether card is finish to program to use busy line. If unstable card is keep holding busy line while writing using DMA.
>>> hang problem happen by wait_for_completion. so I think that mmc driver need some exception to avoid this problem.
>>> I suggest to use wait_for_completion_timeout instead of wait_for_completion.
>>>
>>
>> I see what you are trying to solve, but you can never calculate the timeout for this type of operation in such a way. Your timeout involves the entire data write operation, how can you ever know how long this will take?
>>
>> I think a much better approach is to make you host driver not using "busy signaling" (if that is possible), thus when the DMA job is done call mmc_request_done to finalize the data transfer. The mmc framework will then send a CMD13 (SEND_STATUS) to make sure the data is written before issuing the next request.
>>
>> BR
>> Ulf Hansson
>
>
> To add to what Hansson mentioned, the timeout mechanism should not be
> implemented at the MMC core layer. If the core layer simply times out
> like this, the host controller driver still remains in the same state
> which is not right. If such a timeout mechanism is needed, it is best
> to implement in the host controller driver layer and inform the core
> layer by calling mmc_request_done() when the time out happens. This
> will also give a chance to the host controller driver to do any
> required clean up at the controller layer so that it is in a known
> good state to handle further requests from the core layer.
>
> Regards,
> Murali Krishna
>

yes, I knew. But if card keep holding busy line(data 0) in the middle
of DMA operation(multi blocks write),  host driver layer can not know
card status in this situation. addtionally, After timeout happen, host
driver should send stop cmd to card for putting out busyline. and we
should reset/cleanup host contoller to intialize DMA controller. and
it should be impremented in host driver. so after returing write fail,
host can access card again.

Write_timeout is calculated by the R2W_FACTOR field * mult in the CSD.
but it is timeout about only one block. so I think that timeout value
is multiplied with number of blocks.
I will modify v2 patch by adding this code.

timeout_us = (mrq->data->timeout_ns * mrq->data->blocks)  / 1000;

I think that this exception should be like this.
If write 128KB request  -> timeout is calculated to 6.4 sec if it
spend 250ms per block -> timeout error happen -> mmc core send stop
cmd ->  mmc core try to call host reset/cleanup -> return write cmd
error.

How do you think ?
