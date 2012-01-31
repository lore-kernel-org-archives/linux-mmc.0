From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
Date: Tue, 31 Jan 2012 09:28:32 +0530
Message-ID: <1327982312.1527.61.camel@vkoul-udesk3>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk>  <4F1696E4.9070806@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F1696E4.9070806@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "perex@perex.cz" <perex@perex.cz>, Vipin KUMAR <vipin.kumar@st.com>, Mirko GARDI <mirko.gardi@st.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, Pratyush ANAND <pratyush.anand@st.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Deepak SIKRI <deepak.sikri@st.com>, "cjb@laptop.org" <cjb@laptop.org>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux->
List-Id: linux-mmc@vger.kernel.org

On Wed, 2012-01-18 at 15:24 +0530, Viresh Kumar wrote:
> On 1/18/2012 3:06 PM, Russell King - ARM Linux wrote:
> > On Wed, Jan 18, 2012 at 02:41:55PM +0530, Viresh Kumar wrote:
> > NAK.  For reasons stated previously and subsequently ignored.
> > .
> > 
> 
> On 1/18/2012 3:05 PM, Russell King - ARM Linux wrote:
> >> > You implemented similar stuff in amba-pl08x :) .
> >> > 
> >> > if (!plchan->slave)
> >> > 	pl08x_unmap_buffers(txd);
> > Take a look at that.  "If *NOT* slave, unmap the buffers".
> 
> [Following is picked from current implementation of dw_dmac:]
> 
> 	if (!dwc->chan.private) {
> 		struct device *parent = chan2parent(&dwc->chan);
> 		if (!(txd->flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
> 
> Sorry, I missed the most straight forward looking code. :(
> Actually, dw_dmac is also doing the same, i.e. unmapping only for
> non-slave transfers.
> 
> The same patch is still applicable, after fixing message subject and log.
> I will resend it, with message log fixed, once i get more feedbacks on V2.
> 
But this patch seems to unmap for *all* descriptors, so you need to fix
that as well, apart from the ones stated above.


-- 
~Vinod
