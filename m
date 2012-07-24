From: "Yaniv Gardi" <ygardi@codeaurora.org>
Subject: RE: [PATCH RESEND v7 2/2] mmc: card: Adding support for sanitize      in eMMC 4.5
Date: Tue, 24 Jul 2012 09:40:08 +0300
Message-ID: <000001cd6967$2ce2a010$86a7e030$@codeaurora.org>
References: <1340872367-16206-1-git-send-email-ygardi@codeaurora.org>    <1340872367-16206-3-git-send-email-ygardi@codeaurora.org>    <87629k9rkc.fsf@octavius.laptop.org> <f5830acb2ddca29357a0125cd8f3d577.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <f5830acb2ddca29357a0125cd8f3d577.squirrel@www.codeaurora.org>
Content-language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 'open list' <linux-kernel@vger.kernel.org>, merez@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Are there any additional open issues to discuss regarding the sanitize
capability ?
If not, we would like to see this patch pushed into mmc-next.

Thanks,
Yaniv

= > -----Original Message-----
= > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
= > owner@vger.kernel.org] On Behalf Of merez@codeaurora.org
= > Sent: Thursday, July 19, 2012 2:25 PM
= > To: Chris Ball
= > Cc: Yaniv Gardi; linux-mmc@vger.kernel.org; merez@codeaurora.org;
= > linux-arm-msm@vger.kernel.org; open list
= > Subject: Re: [PATCH RESEND v7 2/2] mmc: card: Adding support for
= > sanitize in eMMC 4.5
= > 
= > On Wed, July 18, 2012 11:46 pm, Chris Ball wrote:
= > > Hi Yaniv,
= > >
= > > On Thu, Jun 28 2012, Yaniv Gardi wrote:
= > >> This feature delete the unmap memory region of the eMMC card, by
= > >> writing to a specific register in the EXT_CSD unmap region is the
= > >> memory region that were previously deleted (by erase, trim or discard
= > >> operation)
= > >>
= > >> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
= > >
= > > Did you reply to Chuanxiao's review comments yet?  He said:
= > >
= > > "So to implement your scenario, how about only add
= > > mmc_blk_issue_sanitize_rq() for REQ_SANITIZE but not touch
= > > mmc_blk_issue_secdiscard_rq()? With your changes in
= > > mmc_blk_issue_secdiscard_rq(), eMMC4.5 device will be failed to
= > > operate secure trim/erase for REQ_SECURE request."
= > >
= > > at:
= > http://thread.gmane.org/gmane.linux.kernel.mmc/14822/focus=14880
= > >
= > > Thanks,
= > >
= > > - Chris.
= > > --
= > > Chris Ball   <cjb@laptop.org>   <http://printf.net/>
= > > One Laptop Per Child
= > >
= > 
= > Secure trim and secure erase were removed from eMMC4.5. Please refer
= > to annex B at B.6 section in eMMC4.5 spec.
= > Therefore, failure upon trying to do secure trim/erase is the expected
= > behavior for eMMC4.5 devices.
= > 
= > Thanks,
= > Maya
= > --
= > Sent by consultant of Qualcomm Innovation Center, Inc.
= > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
= > 
= > --
= > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the
= > body of a message to majordomo@vger.kernel.org More majordomo info
= > at  http://vger.kernel.org/majordomo-info.html
