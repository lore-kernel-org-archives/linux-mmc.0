From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v3 1/1] mmc: core: skip card initialization if power class
 selection fails
Date: Fri, 13 Apr 2012 23:41:56 +0900
Message-ID: <CAKYAXd-HfDL1AXJ=X-+iTjqCcVTF=1=J-RBBNU05r9P+om_6bQ@mail.gmail.com>
References: <1334239567-22285-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1334239567-22285-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2012/4/12 Subhash Jadavani <subhashj@codeaurora.org>:
> With current implementation of power class selection,
> mmc_select_powerclass() should never fail. So treat any error
> returned by this function as serious enough to skip the card
> initialization.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> ---
