From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v6 8/9] mmc: dw_mmc: add support for implementation
 specific callbacks
Date: Thu, 04 Oct 2012 21:41:07 +0900
Message-ID: <001e01cda22d$86383130$92a89390$%jun@samsung.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
 <1347905803-22742-9-git-send-email-thomas.abraham@linaro.org>
 <001401cd966c$5fe94590$1fbbd0b0$%jun@samsung.com>
 <CAJuYYwRUhK858ixLfZPz9UVmqJBe0=LdgjhLfazPNHE3zckDjQ@mail.gmail.com>
 <m3haqodsvb.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m3haqodsvb.fsf@pullcord.laptop.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Monday, September 24, Chris Ball <cjb@laptop.org>
> Hi,
> 
> On Thu, Sep 20 2012, Thomas Abraham wrote:
> >> In non-Exynos platform, host->drv_data has NULL.
> >
> > Yes, sorry, I missed that.
> >
> > Chris, should I fix this and send the updated patch or shall I send a
> > separate fix patch.
> 
> A separate fix patch would be good, please.
> 
> (I'd normally take an updated patch but Stephen Rothwell's asked for
> people to hold off rebasing now that -rc7 is out, which is reasonable.)
Thomas,

Is there any work for fix?

Thanks,
Seungwon Jeon

> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
