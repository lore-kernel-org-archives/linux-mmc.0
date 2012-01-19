From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 03/12] dmaengine: Pass dma_slave_config .device_fc =
 NULL for all existing users
Date: Thu, 19 Jan 2012 18:00:43 +0100
Message-ID: <CACRpkdYjLyYx-pDLA+FqT+=Vdop4jF4+ex6D6o9udNbN57+=Zg@mail.gmail.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <104f6d8b3c4a2d65dce9eb32364d32eba637c48d.1326876464.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <104f6d8b3c4a2d65dce9eb32364d32eba637c48d.1326876464.git.viresh.kumar@st.com>
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
Cc: rajeev-dlh.kumar@st.com, bhupesh.sharma@st.com, mirko.gardi@st.com, perex@perex.cz, vipin.kumar@st.com, vipulkumar.samar@st.com, egtvedt@samfundet.no, pratyush.anand@st.com, vinod.koul@intel.com, deepak.sikri@st.com, rmk+kernel@arm.linux.org.uk, cjb@laptop.org, hskinnemoen@gmail.com, bhavna.yadav@st.com, armando.visconti@st.com, shiraz.hashim@st.com, amit.virdi@st.com, vincenzo.frascino@st.com, dan.j.williams@intel.com, ulf.hansson@stericsson.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.linux@gmail.com, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 18, 2012 at 10:11 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> .device_fc is added in struct dma_slave_config recently. All user drivers, which
> want DMA to be the flow controller must pass this field as false. As earlier
> driver don't look to use this feature, mark it false for now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Viresh,
Linus Walleij
