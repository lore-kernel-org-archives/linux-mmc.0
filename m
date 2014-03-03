From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: host: dw: fix possible build error
Date: Mon, 03 Mar 2014 19:01:53 +0000
Message-ID: <86vbvvqf6m.fsf@void.printf.net>
References: <1393340264-22687-1-git-send-email-balbi@ti.com>
	<530D134F.5090403@samsung.com> <20140303180614.GA31301@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140303180614.GA31301@saruman.home> (Felipe Balbi's message of
	"Mon, 3 Mar 2014 12:06:14 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Jaehoon Chung <jh80.chung@samsung.com>, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Mar 03 2014, Felipe Balbi wrote:
>> When you send the patch related with dw_mmc controller, could you use
>> the prefix "mmc: dw_mmc:"?  "mmc: dw_mmc: fix possible build error"
>
> sure, no problem. Do I *really* need to resend though ? It's already
> -rc5 and I still don't see this patch merged.

No need to resend, I can fix this up -- pushed to mmc-next, thanks.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
