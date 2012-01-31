From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 02/12] dmaengine: Add flow controller information to
 dma_slave_config
Date: Tue, 31 Jan 2012 09:25:21 +0530
Message-ID: <4F276629.7000608@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
 <1327982082.1527.60.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1327982082.1527.60.camel@vkoul-udesk3>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, Mirko GARDI <mirko.gardi@st.com>, "perex@perex.cz" <perex@perex.cz>, Vipin KUMAR <vipin.kumar@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, Pratyush ANAND <pratyush.anand@st.com>, Deepak SIKRI <deepak.sikri@st.com>, "rmk+kernel@arm.linux.org.uk" <rmk+kernel@arm.linux.org.uk>, "cjb@laptop.org" <cjb@laptop.org>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 1/31/2012 9:24 AM, Vinod Koul wrote:
>> > + * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
> ccfg maybe true for your controller, not others...
> 

:(

Will fix the comment.

-- 
viresh
