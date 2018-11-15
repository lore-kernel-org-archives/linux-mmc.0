From: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Subject: Re: remove more legacy request leftover
Date: Thu, 15 Nov 2018 12:20:19 -0700
Message-ID: <3999c98e-e477-c7d0-0a7f-a65d69f3e4e1@kernel.dk>
References: <20181114160219.28328-1-hch@lst.de>
	<6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
In-Reply-To: <6927069f-46d4-2d37-058a-c9c9b9d5360d-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 11/15/18 12:14 PM, Jens Axboe wrote:
> On 11/14/18 9:02 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series removes another bunch of legacy request leftovers,
>> including the pointer indirection for the queue_lock.
> 
> Applied, with the subname part removed as mentioned in #13.

Your patch #16 missed a few spots, I fixed it up. JFYI.

-- 
Jens Axboe
