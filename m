From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
Date: Thu, 19 Jan 2012 18:36:24 +0100
Message-ID: <CACRpkdZrPKunfKOF0mqR-9DOZhCFAzwZHJ2gCZRjbC3TuqecvQ@mail.gmail.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk>
 <4F1696E4.9070806@st.com>
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
Cc: Mirko GARDI <mirko.gardi@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "perex@perex.cz" <perex@perex.cz>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "vinod.koul@intel.com" <vinod.koul@intel.com>, Deepak SIKRI <deepak.sikri@st.com>, "cjb@laptop.org" <cjb@laptop.org>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Armando VISCONTI <armando.visconti@st.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kerne>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 18, 2012 at 10:54 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Actually, dw_dmac is also doing the same, i.e. unmapping only for
> non-slave transfers.

Problem solved :-)

Yours,
Linus Walleij
