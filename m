From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V3 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of non-slave transfers
Date: Mon, 6 Feb 2012 13:41:40 +0530
Message-ID: <4F2F8B3C.7050107@st.com>
References: <cover.1328091915.git.viresh.kumar@st.com>
 <c098ca5959c947b3634555bc7bf4a8b3af82a2ae.1328091915.git.viresh.kumar@st.com>
 <20120202121523.GG889@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120202121523.GG889@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "perex@perex.cz" <perex@perex.cz>, Vipin KUMAR <vipin.kumar@st.com>, Mirko GARDI <mirko.gardi@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Pratyush ANAND <pratyush.anand@st.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>, Deepak SIKRI <deepak.sikri@st.com>, "cjb@laptop.org" <cjb@laptop.org>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Armando VISCONTI <armando.visconti@st.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-k>
List-Id: linux-mmc@vger.kernel.org

On 2/2/2012 5:45 PM, Russell King - ARM Linux wrote:
> I'm still unconvinced that this is anywhere close to correct.
> 
> Look.  DMA engines only automatically unmap when they're being used by the
> async_tx stuff for memcpy's, and RAID computation offload, and the like.
> These work with individual single buffers, not scatterlists.  These will
> not be fragmented.

Got it. You are right.

@Vinod: Please drop this patch.

-- 
viresh
