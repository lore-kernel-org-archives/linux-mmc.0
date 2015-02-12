From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Optimize write_w path for tegra114 and later
Date: Thu, 12 Feb 2015 11:17:19 -0500
Message-ID: <54DCD20F.7070909@nvidia.com>
References: <1423677351-31635-1-git-send-email-rklein@nvidia.com> <CAAVeFuKVWGExO2y9cb=icvGmNZWTnYve2w2N25t_ybmSo9MPYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAVeFuKVWGExO2y9cb=icvGmNZWTnYve2w2N25t_ybmSo9MPYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2/11/2015 10:50 PM, Alexandre Courbot wrote:
> On Thu, Feb 12, 2015 at 2:55 AM, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Setup a different set of sdhci_ops for tegra114 and later so that
>> the write_w callback is only used on tegra114. This allows us to
>> remove the NVQUIRK_SHADOW_XFER_MODE_REG and simply the logic
>> in tegra_sdhci_writew.
>>
>> This was suggested by Alexandre Courbot.
> 
> There's a tag for that. ;)
> 
> Suggested-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
>>
>> Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Thanks for keeping up with this!
> 

Ahh I figured there had to be one but I wasn't sure. Ulf, I can repost
this if you want unless you want to just update the commit msg (assuming
there are no other complaints).

-rhyland

-- 
nvpublic
