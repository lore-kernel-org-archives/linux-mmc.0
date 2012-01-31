From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
Date: Tue, 31 Jan 2012 11:06:16 +0530
Message-ID: <1327988176.1527.66.camel@vkoul-udesk3>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk> <4F1696E4.9070806@st.com>
 <1327982312.1527.61.camel@vkoul-udesk3> <4F27691A.5010503@st.com>
 <1327986775.1527.63.camel@vkoul-udesk3>  <4F2779F5.3000701@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F2779F5.3000701@st.com>
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

On Tue, 2012-01-31 at 10:49 +0530, Viresh Kumar wrote:
> On 1/31/2012 10:42 AM, Vinod Koul wrote:
> > Btw, can you also fix the driver not to use chan->private?
> 
> Ya sure, but i am not in sync with the issue. :(
> Why do we need to remove code dependency on chan->private, something
> dmaengine specific has changed?
> 
its deprecated :)
You should be using dma_slave_config instead to pass the required
parameters

-- 
~Vinod
