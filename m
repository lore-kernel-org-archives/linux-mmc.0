From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 06/10] mmc: core: move the cookie's enum values from
 sdhci.h to mmc.h
Date: Wed, 16 Nov 2016 10:28:45 +0200
Message-ID: <d5321daf-b449-e556-ccf1-cd82d497ea85@intel.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <CGME20161115101332epcas2p2c10c90b955b427a510ed8f9631b3fdfe@epcas2p2.samsung.com>
 <20161115101232.3854-7-jh80.chung@samsung.com>
 <12405f58-695d-03d8-407f-d7471e93a6de@samsung.com>
 <ecb4b5d0-4cbf-bf44-3287-f1580b2e990a@intel.com>
 <89535076-4a77-64a5-68d9-ce15e03b8fb3@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <89535076-4a77-64a5-68d9-ce15e03b8fb3-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 16/11/16 10:25, Jaehoon Chung wrote:
> On 11/16/2016 05:09 PM, Adrian Hunter wrote:
>> On 16/11/16 09:53, Jaehoon Chung wrote:
>>> Added Adrian for sdhci.h
>>>
>>> On 11/15/2016 07:12 PM, Jaehoon Chung wrote:
>>>> It's not for only sdhci controller.
>>>> So it can be moved from sdhci.h to mmc.h. And renamed from sdhci_cookie
>>>> to mmc_cookie.
>>
>> The cookie is currently host private data, so I don't understand the
>> motivation behind this.
> 
> dwmmc controller can also use the data->host_cookie. because it's working with post/pre_req().
> 
> So i think it can be used about both sdhci and dwmmc.
> Is there no reason that add the private dwmmc data?
> 
> With these cookie value, update the dwmmc controller for post/pre_req().
> 
> https://patchwork.kernel.org/patch/9429287/

So why not define dwmmc cookies in dw_mmc.c ?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
