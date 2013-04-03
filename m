From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: Re: [PATCH v5 2/3] block: Add API for urgent request handling
Date: Wed, 03 Apr 2013 13:40:46 +0300
Message-ID: <515C072E.3010801@codeaurora.org>
References: <1364202178-8936-1-git-send-email-tlinder@codeaurora.org> <20130325124007.GH22327@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130325124007.GH22327@kernel.dk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Alex.Lemberg@sandisk.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3/25/2013 2:40 PM, Jens Axboe wrote:
> On Mon, Mar 25 2013, Tanya Brokhman wrote:
>> This patch add support in block & elevator layers for handling
>> urgent requests. The decision if a request is urgent or not is taken
>> by the scheduler. Request is marked as urgent in cmd_flags (by the
>> scheduler) with a new flag - REQ_URGENT.
>> Urgent request notification is passed to the underlying
>> block device driver (eMMC for example). Block device driver may deci=
de to
>> interrupt the currently running low priority request to serve the ne=
w
>> urgent request. By doing so READ latency is greatly reduced in read&=
write
>> collision scenarios.
>>
>> Note that if the current scheduler doesn't implement the urgent requ=
est
>> mechanism, this code path is never activated.
> I really don't like this out-of-band mechanism. Lets say there is an
> urgent request, the IO scheduler would put that at the head of the
> queue. So the first time the driver fetches a request, it'll see this
> urgent request. A driver that has support for this, would check the h=
ead
> of queue everytime its request_fn was invoked. There's no need to add=
 a
> elevator_is_urgent_fn() and ->notified_urgent.
>
Hi Jens,

Thank you for your inputs. We implemented the URGENT request=20
notification in block layer with elevator_is_urgent_fn() and=20
->notified_urgent due to the following:

1. In the future the URGENT request mechanism may be of use to other=20
block device drivers besides mmc (such as sdcc for example). Having thi=
s=20
mechanism in the block layer spares all of the block devices=20
re-implementing it.

2. Using the existing API (->request_fn() and not urgent_request->fn())=
=20
won=92t work as intended for URGENT requests in case the block device=20
already handles 2 requests. In such a case, when a device driver will=20
peek the dispatch queue to check if an URGENT request is pending or not=
,=20
a new request will be dispatched. If an URGENT requests is inserted to=20
the scheduler after that, the block device will not be aware of its=20
existence, which will result in high latency for this URGENT request.=20
=46or example:

The device driver is currently handling requests regular_A and regular_=
B=20
when a new regular request ( regular_C ) arrives and ->request_fn() is=20
called by the block layer. The device driver =94peeks=94 the dispatch q=
ueue=20
in order to find out if there is an URGENT request pending. The I/O=20
scheduler will insert regular_C into the dispatch queue, the device=20
driver will see that there is no URGNET request pending and continue it=
s=20
work. Regular_C will remain pending on the dispatch queue. Now another=20
request arrives: URGENT_D and ->request_fn() is called again. But this=20
time when the device driver =93peeks=94 the dispatch queue to find if a=
n=20
URGENT request is pending it will look at regular_C and URGENT_D will=20
remain in the scheduler data base till regular_A and regular_B requests=
=20
are completed and regular_C is sent to the card.

The ->notified_urgent is needed because we don=92t want to notify the=20
device driver of an URGENT request if there is already an URGENT reques=
t=20
in flight. This is because we don=92t want URGENT requests to be interr=
upted.

--=20

QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber

of Code Aurora Forum, hosted by The Linux Foundation
