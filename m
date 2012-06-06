From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Wed, 06 Jun 2012 09:30:30 -0400
Message-ID: <87mx4g4lft.fsf@octavius.laptop.org>
References: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org>
	<87pqbfv3e1.fsf@laptop.org>
	<000201cd174a$f3019b80$d904d280$@codeaurora.org>
	<000301cd1d22$57444d40$05cce7c0$@codeaurora.org>
	<CAKYAXd9QfEEJLQGG6PJgnNyyXP4D2Sa-PqhiZ=dDdQv50z76+A@mail.gmail.com>
	<000001cd35af$2eae5ba0$8c0b12e0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <000001cd35af$2eae5ba0$8c0b12e0$@codeaurora.org> (Subhash
	Jadavani's message of "Sat, 19 May 2012 16:34:19 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 'Namjae Jeon' <linkinjeon@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, May 19 2012, Subhash Jadavani wrote:
> Do you see any issues with this patch?

No, no issues -- please could I ask you to refresh it against 3.5-rc1
(it no longer applies) and add your performance numbers to the commit
message?  I'll push it to mmc-next and probably merge for 3.6, so that
we have a full round of linux-next for anyone to notice problems.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
