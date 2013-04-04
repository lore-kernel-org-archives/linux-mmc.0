From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1] mmc: card: Adding support for sanitize in eMMC 4.5
Date: Thu, 04 Apr 2013 10:20:54 -0400
Message-ID: <877gkipebd.fsf@octavius.laptop.org>
References: <1361705927-10524-1-git-send-email-ygardi@codeaurora.org>
	<26E7A31274623843B0E8CF86148BFE32B02F5779@NTXAVZMBX04.azit.micron.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26E7A31274623843B0E8CF86148BFE32B02F5779@NTXAVZMBX04.azit.micron.com>
	(Luca Porzio's message of "Mon, 11 Mar 2013 18:36:55 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: Yaniv Gardi <ygardi@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Yaniv, Maya,

On Mon, Mar 11 2013, Luca Porzio (lporzio) wrote:
> In case of Sanitize timeout, the eMMC might go in an unclear state.
> May I suggest to:
> - issue an HPI before leaving thus bring the eMMC back into safe status
> - report the 'sanitize not complete error' and let the user decide on 
>   Whether he wants to re-issue (i.e. continue) the sanitize or just let 
>   it go.

Can you respond to this review feedback from Luca, please?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
