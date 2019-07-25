From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add PLL Enable support to internal clock
 setup
Date: Wed, 24 Jul 2019 21:47:21 -0400
Message-ID: <20190725014721.GA7239@people.danlj.org>
References: <20190717023951.5064-1-ben.chuang@genesyslogic.com.tw>
 <CAPDyKFqgTnudMumvrCJqi8FDfNNUU5AedP3hV=hwO1roG336Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqgTnudMumvrCJqi8FDfNNUU5AedP3hV=hwO1roG336Hw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ben Chuang <ben.chuang@genesyslogic.com.tw>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 24, 2019 at 09:19:30AM +0200, Ulf Hansson wrote:
> > Genesys Logic Email Confidentiality Notice:
> > This mail and any attachments may contain information that is confidential, proprietary, privileged or otherwise protected by law. The mail is intended solely for the named addressee (or a person responsible for delivering it to the addressee). If you are not the intended recipient of this mail, you are not authorized to read, print, copy or disseminate this mail.
> >
> > If you have received this email in error, please notify us immediately by reply email and immediately delete this message and any attachments from your system. Please be noted that any unauthorized use, dissemination, distribution or copying of this email is strictly prohibited.
> > ________________________________
> 
> If you want me to apply the patch, you have to drop the above notice.

Ben is the primary author and can respond on the requested code
changes; I helped break the work apart into the two patches and
did small changes to improve the code.

Ben's SMTP server at Genesys auto-appends the confidentiality
notice without giving him the opportunity to control it.  I have
the patch set co-developed in a shared Git repository without the
automated email addition ever applied, so when Ben works out the
substantial changes, I can send final patches to the list without
the mail-mangling robot getting in the way.  He'll still be the
primary author.
