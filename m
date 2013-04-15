From: merez@codeaurora.org
Subject: Re: [PATCH v1] mmc: card: Adding support for sanitize in eMMC 4.5
Date: Mon, 15 Apr 2013 01:08:10 -0700
Message-ID: <8c0a691851491a66c7df58b9a2ca89ec.squirrel@www.codeaurora.org>
References: <1361705927-10524-1-git-send-email-ygardi@codeaurora.org>
    <26E7A31274623843B0E8CF86148BFE32B02F5779@NTXAVZMBX04.azit.micron.com>
    <877gkipebd.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <877gkipebd.fsf@octavius.laptop.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Luca Porzio (lporzio)" <lporzio@micron.com>, Yaniv Gardi <ygardi@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris and Luca,

Sorry for the late response.
Yaniv is on vacation for the last month and will be back at the end of the
week.
We will add the HPI in case Sanitize times-out.

Thanks,
Maya

> Hi Yaniv, Maya,
>
> On Mon, Mar 11 2013, Luca Porzio (lporzio) wrote:
>> In case of Sanitize timeout, the eMMC might go in an unclear state.
>> May I suggest to:
>> - issue an HPI before leaving thus bring the eMMC back into safe status
>> - report the 'sanitize not complete error' and let the user decide on
>>   Whether he wants to re-issue (i.e. continue) the sanitize or just let
>>   it go.
>
> Can you respond to this review feedback from Luca, please?
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
>


-- 
Maya Erez
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
