From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC PATCH] mmc: support background operation
Date: Tue, 16 Aug 2011 12:43:57 -0400
Message-ID: <m21uwlux0y.fsf@bob.laptop.org>
References: <4E450B21.8040502@samsung.com> <4E4A9C40.3000708@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60283 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636Ab1HPQoM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2011 12:44:12 -0400
In-Reply-To: <4E4A9C40.3000708@linux.intel.com> (J. Freyensee's message of
	"Tue, 16 Aug 2011 09:35:12 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

Hi,

On Tue, Aug 16 2011, J Freyensee wrote:
> On 08/12/2011 04:14 AM, Jaehoon Chung wrote:
>> Hi mailing.
>>
>> This RFC patch is supported background operation(BKOPS).
>> And if you want to test this patch, must apply "[PATCH v3] mmc:
>> support HPI send command"
>>
>> This patch is based on Hanumath Prasad's patch "mmc: enable
>> background operations for emmc4.41 with HPI support"
>> Hanumath's patch is implemented before applied per forlin's patch
>> "use nonblock mmc request...".
>> This patch is based on 3.1.0-rc1 in mmc-next.
>
> I'm a little confused by this statement.  Was this patch done before
> Per Forlin's work, or is this patch the implementation of the
> infrastructure Per Forlin worked on to do non-blocking requests to the
> host controller?

As I understand it, the background operations referred to by this patch
are a feature of the spec/card, whereas the background operations in Per
Forlin's nonblocking patch are merely a feature of the DMA preparation
being done in the kernel (invisibly to the card).

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
