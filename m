From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v3 1/1] mmc: core: skip card initialization if power class selection fails
Date: Wed, 25 Apr 2012 18:25:47 +0530
Message-ID: <000601cd22e2$be450500$3acf0f00$@codeaurora.org>
References: <1334239567-22285-1-git-send-email-subhashj@codeaurora.org> <CAKYAXd-HfDL1AXJ=X-+iTjqCcVTF=1=J-RBBNU05r9P+om_6bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKYAXd-HfDL1AXJ=X-+iTjqCcVTF=1=J-RBBNU05r9P+om_6bQ@mail.gmail.com>
Content-language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Namjae Jeon' <linkinjeon@gmail.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Is this patch looks ok?

Regards,
Subhash

> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Namjae Jeon
> Sent: Friday, April 13, 2012 8:12 PM
> To: Subhash Jadavani; Chris Ball
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org
> Subject: Re: [PATCH v3 1/1] mmc: core: skip card initialization if power class
> selection fails
> 
> 2012/4/12 Subhash Jadavani <subhashj@codeaurora.org>:
> > With current implementation of power class selection,
> > mmc_select_powerclass() should never fail. So treat any error returned
> > by this function as serious enough to skip the card initialization.
> >
> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Looks good to me.
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> > ---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
