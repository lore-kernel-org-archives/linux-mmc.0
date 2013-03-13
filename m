From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt
Date: Wed, 13 Mar 2013 10:26:46 -0400
Message-ID: <87a9q7fk9l.fsf@octavius.laptop.org>
References: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com>
	<002501ce1ff6$38e3c470$aaab4d50$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <002501ce1ff6$38e3c470$aaab4d50$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 13 Mar 2013 23:22:40 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Markos Chandras' <markos.chandras@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 13 2013, Seungwon Jeon wrote:
> On Tuesday, March 12, 2013, Markos Chandras wrote:
>> There is no reason to loop when handling an interrupt. The "if" clauses
>> will handle all of them sequentially. This also eliminates the extra loop
>> we used to take with no pending interrupts and we ended up breaking out
>> of the while loop.
>> 
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> You can add my ack to other patches.
> However, could you change the subject prefix to 'mmc: dw_mmc' and resend?

It's okay, I'll take care of that when applying this time.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
